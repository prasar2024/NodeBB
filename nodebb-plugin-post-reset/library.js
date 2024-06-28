'use strict';

const schedule = require('node-schedule');
const db = require.main.require('../src/database'); // Adjust the path as necessary
const winston = require.main.require('winston');

const PostResetJob = {};

PostResetJob.init = async function (params) {
    const job = schedule.scheduleJob('0 0 1 * *', async function () {
        try {
            const keys = await db.getKeys('user:*:postcount:month:*');
            const multi = db.batch();
            keys.forEach((key) => multi.del(key));
            await multi.exec();
        } catch (err) {
            winston.error(`[monthly-reset] Error resetting post counts: ${err.message}`);
        }
    });
};

module.exports = PostResetJob;
