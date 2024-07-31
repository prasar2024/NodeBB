'use strict';

const express = require('express');
const Razorpay = require('razorpay');
const router = express.Router();
const { key_id, key_secret } = require('../razorpayConfig');
const path = require('path');
const winston = require('winston');
const groups = require('../groups'); // Ensure groups module is required correctly
const crypto = require('crypto');

const razorpay = new Razorpay({
  key_id,
  key_secret,
});

router.post('/create-order', async (req, res) => {
  const { amount, currency, receipt, uid } = req.body;

  const isSilverRole = await groups.isMember(uid, 'silver-role');
  if (isSilverRole) {
    res.status(400).json({ message: 'Plan already purchased' });
    return;
  }

  try {
    let order = await razorpay.orders.create({ amount, currency, receipt });
    console.log('Order created:', order); // Log created order
    
    order.uid = uid;

    res.status(200).json(order);
  } catch (err) {
    winston.error(`[razorpay] Error creating order: ${err.message}`);
    if (err.error) {
      winston.error(`[razorpay] Error details: ${JSON.stringify(err.error)}`);
    }
    res.status(500).send('Error creating order');
  }
});

router.post('/get-user-plan', async (req, res) => {
  const { uid } = req.body;

  const isSilverRole = await groups.isMember(uid, 'silver-role');
  res.status(200).json({ isSilverRole });
});

router.post('/verify-payment/:uid', async (req, res) => {
  const { razorpay_order_id, razorpay_payment_id, razorpay_signature } = req.body;
  const { uid } = req.params;

  const generated_signature = require('crypto').createHmac('sha256', key_secret)
    .update(`${razorpay_order_id}|${razorpay_payment_id}`)
    .digest('hex');


  if (generated_signature === razorpay_signature) {
    try {
      const isFreeRole = await groups.isMember(uid, 'free-role');
      if (isFreeRole) {
        await groups.leave('free-role', uid);
        await groups.join('silver-role', uid);
        winston.info(`[razorpay] User ${uid} upgraded to silver role`);
        res.sendFile(path.join(__dirname, 'pages', 'success.html')); // Send success page
      } else {
        res.sendFile(path.join(__dirname, 'pages', 'failure.html')); // Send failure page if user is not in free-role
      }
    } catch (err) {
      winston.error(`[razorpay] Error updating user role: ${err.message}`);
      res.status(500).send({ status: 'error', message: 'Error updating user role' });
    }
  } else {
    res.sendFile(path.join(__dirname, 'pages', 'failure.html')); // Send failure page if verification fails
  }
});

router.post('/verify-landing-payment/:uid', async (req, res) => {
  const { razorpay_order_id, razorpay_payment_id, razorpay_signature } = req.body;
  const { uid } = req.params;

  const generated_signature = require('crypto').createHmac('sha256', key_secret)
    .update(`${razorpay_order_id}|${razorpay_payment_id}`)
    .digest('hex');


  if (generated_signature === razorpay_signature) {
    try {
      const isFreeRole = await groups.isMember(uid, 'free-role');
      if (isFreeRole) {
        await groups.leave('free-role', uid);
        await groups.join('silver-role', uid);
        winston.info(`[razorpay] User ${uid} upgraded to silver role`);
        res.status(200).json({ status: 'success', message: 'User upgraded to silver role' }); 
      } else {
        res.status(400).json({ status: 'error', message: 'Plan upgrade failed' }); 
      }
    } catch (err) {
      winston.error(`[razorpay] Error updating user role: ${err.message}`);
      res.status(500).send({ status: 'error', message: 'Error updating user role' });
    }
  } else {
    res.status(400).json({ status: 'error', message: 'Payment verification failed' });
  }
});


module.exports = router;
