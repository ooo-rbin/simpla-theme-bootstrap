{$meta_title="Вход" scope=parent}
{$meta_robots="noindex, nofollow, noarchive" scope=parent}
<nav>
	<ol class="breadcrumb">
		<li><a href="/">Главная</a></li>
		<li><a href="/user">Пользователь</a></li>
		<li class="active">Вход</li>
	</ol>
	<ul class="nav nav-tabs">
		<li class="active"><a href="/user/login">Вход</a></li>
		<li><a href="/user/register">Регистрация</a></li>
		<li><a href="/user/password_remind">Напомнить пароль</a></li>
	</ul>
</nav>
<form enctype="multipart/form-data" method="post" id="user" class="form well well-top" action="/user/login">
	{if $error}
		<div class="well"><span class="text-danger">
			<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
			{if $error=='login_incorrect'}Неверный логин или пароль
			{elseif $error=='user_disabled'}Ваш аккаунт еще не активирован.
			{else}{$error}{/if}
		</span></div>
	{/if}
	<div class="form-group{if $error} {if $error=='login_incorrect' || $error=='user_disabled'}has-error has-feedback{else}has-success has-feedback{/if}{/if}">
		<label class="sr-only" for="login_email">Email</label>
		<div>
			<div class="input-group">
				<span class="input-group-addon"><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span></span>
				<input placeholder="Email" type="email" class="form-control" id="login_email" name="email" pattern=".+" required maxlength="255" value="{$email|escape}">
			</div>
			{if $error}{if $error=='login_incorrect' || $error=='user_disabled'}
				<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
				<span class="sr-only">(ошибка)</span>
			{else}
				<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
				<span class="sr-only">(верно)</span>
			{/if}{/if}
		</div>
	</div>
	<div class="form-group{if $error} {if $error=='login_incorrect' || $error=='user_disabled'}has-error{else}has-success{/if}{/if}">
		<label class="sr-only" for="login_password">Пароль</label>
		<div>
			<div class="input-group">
				<span class="input-group-addon"><span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span></span>
				<input placeholder="Пароль" type="password" class="form-control" id="login_password" name="password" required value="">
				<span class="input-group-addon"><a rel="nofollow" href="/user/password_remind">Напомнить</a></span>
			</div>
			{if $error}{if $error=='login_incorrect' || $error=='user_disabled'}
				<span class="sr-only">(ошибка)</span>
			{else}
				<span class="sr-only">(верно)</span>
			{/if}{/if}
		</div>
	</div>
	<small class="pull-right help-block">Все поля обязательны для заполнения</small>
	<input type="submit" class="btn btn-primary" name="login" value="Войти">
</form>
		