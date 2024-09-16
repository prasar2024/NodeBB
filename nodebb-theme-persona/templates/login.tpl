<!-- IMPORT partials/breadcrumbs.tpl -->
<div data-widget-area="header">
	{{{each widgets.header}}}
	{{widgets.header.html}}
	{{{end}}}
</div>
<div class="container login">
	<div class="col-lg-10 col-md-12 mx-auto">
		<div class="row my-4">
			<div class="col-12 text-center">
				<h1 class="display-5 lead" style="letter-spacing: 2px">Welcome back to PropertyHawk 👋</h1>
			</div>
			<div class="row">
				{{{ if allowLocalLogin }}}
				<div class="login-block">
					<div class="alert alert-danger {{{ if !error }}}d-none{{{ end }}}" id="login-error-notify">
						<strong>[[login:failed-login-attempt]]</strong>
						<p class="mb-0">{error}</p>
					</div>

					<form class="form-horizontal" role="form" method="post" id="login-form">
						<div class="mb-4">
							<label for="username" class="form-label" style="font-size: 1.2rem;">{allowLoginWith}</label>
							<input class="form-control rounded-pill p-3" type="text" placeholder="{allowLoginWith}" name="username" id="username" autocorrect="off" autocapitalize="off" autocomplete="nickname" value="{username}" />
						</div>
						<div class="mb-4">
							<label for="password" class="form-label" style="font-size: 1.2rem;">[[user:password]]</label>
							<input class="form-control rounded-pill p-3" type="password" placeholder="[[user:password]]" name="password" id="password" autocomplete="current-password" autocapitalize="off" />
							<p id="caps-lock-warning" class="text-danger d-none">
								<i class="fa fa-exclamation-triangle"></i> [[login:caps-lock-enabled]]
							</p>
						</div>
						<div class="mb-4 form-check">
							<input class="form-check-input" type="checkbox" name="remember" id="remember" checked />
							<label class="form-check-label" for="remember" style="font-size: 1.1rem;">[[login:remember-me]]</label>
						</div>

						{{{ each loginFormEntry }}}
						<div class="mb-4 loginFormEntry {./styleName}">
							<label for="{./inputId}" class="form-label" style="font-size: 1.2rem;">{./label}</label>
							<div>{./html}</div>
						</div>
						{{{end}}}

						<input type="hidden" name="_csrf" value="{config.csrf_token}" />
						<input type="hidden" name="noscript" id="noscript" value="true" />
						<div class="d-grid">
							<button class="btn btn-primary btn-lg rounded-pill" id="login" type="submit" style="font-size: 1.2rem;">[[global:login]]</button>
						</div>
						<div class="mt-3 text-center">
							{{{ if allowRegistration }}}
							<p style="font-size: 1.1rem;">[[login:dont-have-account]] <a href="{config.relative_path}/register">[[register:register]]</a></p>
							{{{ end }}}
							{{{ if allowPasswordReset }}}
							<p>
								<a id="reset-link" href="{config.relative_path}/reset" style="font-size: 1.1rem;">[[login:forgot-password]]</a>
							</p>
							{{{ end }}}
						</div>
					</form>
				</div>
				{{{ end }}}

				{{{ if alternate_logins }}}
				<div class="alt-login-block mt-4">
					<h4 class="text-center" style="font-size: 1.3rem;">[[login:alternative-logins]]</h4>
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
