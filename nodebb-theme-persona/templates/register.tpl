<!-- IMPORT partials/breadcrumbs.tpl -->
<div data-widget-area="header">
	{{{each widgets.header}}}
	{{widgets.header.html}}
	{{{end}}}
</div>
<div class="container register">
	<div class="col-lg-10 col-md-12 mx-auto">
		<div class="row my-4">
			<div class="col-12 text-start">
				<h1 class="display-5 lead" style="letter-spacing: 2px">Get started with PropertyHawk</h1>
			</div>
			<div class="row">
				<div class="register-block">
					<div class="alert alert-danger {{{ if !error }}}d-none{{{ end }}}" id="register-error-notify">
						<strong>[[error:registration-error]]</strong>
						<p>{error}</p>
					</div>
					<form component="register/local" class="form-horizontal" role="form" action="{config.relative_path}/register" method="post">
						
						<div class="mb-4">
							<label class="form-label" style="font-size: 1.2rem;">Role</label>
							<div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="role" id="broker" value="broker" />
									<label class="form-check-label" for="broker" style="font-size: 1.1rem;">Broker</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="role" id="user" value="user" />
									<label class="form-check-label" for="user" style="font-size: 1.1rem;">User</label>
								</div>
							</div>
						</div>
						
						<div class="mb-4">
							<label for="username" class="form-label" style="font-size: 1.2rem;">[[register:username]]</label>
							<input class="form-control rounded-pill p-3" type="text" placeholder="[[register:username-placeholder]]" name="username" id="username" autocorrect="off" autocapitalize="off" autocomplete="nickname" />
							<span class="register-feedback" id="username-notify"></span>
							<span class="form-text" style="font-size: 0.9rem;">[[register:help.username-restrictions, {minimumUsernameLength}, {maximumUsernameLength}]]</span>
						</div>
						<div class="mb-4">
							<label for="password" class="form-label" style="font-size: 1.2rem;">[[register:password]]</label>
							<input class="form-control rounded-pill p-3" type="password" placeholder="[[register:password-placeholder]]" name="password" id="password" autocomplete="new-password" autocapitalize="off" />
							<span class="register-feedback" id="password-notify"></span>
							<span class="form-text" style="font-size: 0.9rem;">[[register:help.minimum-password-length, {minimumPasswordLength}]]</span>
							<p id="caps-lock-warning" class="text-danger d-none">
								<i class="fa fa-exclamation-triangle"></i> [[login:caps-lock-enabled]]
							</p>
						</div>
						<div class="mb-4">
							<label for="password-confirm" class="form-label" style="font-size: 1.2rem;">[[register:confirm-password]]</label>
							<input class="form-control rounded-pill p-3" type="password" placeholder="[[register:confirm-password-placeholder]]" name="password-confirm" id="password-confirm" autocomplete="new-password" autocapitalize="off" />
							<span class="register-feedback" id="password-confirm-notify"></span>
						</div>

						{{{ each regFormEntry }}}
						<div class="mb-4 {./styleName}">
							<label for="{./inputId}" class="form-label" style="font-size: 1.2rem;">{./label}</label>
							<div>{./html}</div>
						</div>
						{{{ end }}}

						<div class="d-grid">
							<button class="btn btn-primary btn-lg rounded-pill" id="register" type="submit" style="font-size: 1.2rem;">[[register:register-now-button]]</button>
						</div>
						<input id="token" type="hidden" name="token" value="" />
						<input id="noscript" type="hidden" name="noscript" value="true" />
						<input type="hidden" name="_csrf" value="{config.csrf_token}" />
					</form>
				</div>

				{{{ if alternate_logins }}}
				<div class="alt-register-block mt-4">
					<h4 class="text-center" style="font-size: 1.3rem;">[[register:alternative-registration]]</h4>
					<ul class="list-inline text-center">
						{{{each authentication}}}
						<li class="list-inline-item {authentication.name}">
							<a rel="nofollow noopener noreferrer" target="_top" href="{config.relative_path}{authentication.url}">
								<i class="fa {authentication.icon} fa-3x"></i>
							</a>
						</li>
						{{{end}}}
					</ul>
				</div>
				{{{ end }}}
			</div>
		</div>
	</div>
	<div data-widget-area="sidebar" class="col-lg-3 col-sm-12 {{{ if !widgets.sidebar.length }}}d-none{{{ end }}}">
		{{{each widgets.sidebar}}}
		{{widgets.sidebar.html}}
		{{{end}}}
	</div>
</div>
<div data-widget-area="footer">
	{{{each widgets.footer}}}
	{{widgets.footer.html}}
	{{{end}}}
</div>
