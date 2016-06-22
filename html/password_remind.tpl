{$meta_title="Напоминание пароля" scope=parent}
{$meta_robots="noindex, nofollow, noarchive" scope=parent}
<nav>
	<ol class="breadcrumb">
		<li><a href="/">Главная</a></li>
		<li><a href="/user">Пользователь</a></li>
		<li class="active">Напомнить пароль</li>
	</ol>
	<ul class="nav nav-tabs">
		<li><a href="/user/login">Вход</a></li>
		<li><a href="/user/register">Регистрация</a></li>
		<li class="active"><a href="/user/password_remind">Напомнить пароль</a></li>
	</ul>
</nav>
<form enctype="multipart/form-data" method="post" id="user" class="form well well-top" action="/user/password_remind">
	{if $email_sent}
		<div class="well"><span class="text-success">
			<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
			На {$email|escape} отправлено письмо для восстановления пароля.
		</span></div>
	{else}
		{if $error}
			<div class="well bg-warning"><span class="text-danger">
				<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				{if $error=='user_not_found'}Пользователь не найден{else}{$error}{/if}
			</span></div>
		{/if}
		<div class="form-group{if $error} {if $error=='user_not_found'}has-error has-feedback{else}has-success has-feedback{/if}{/if}">
			<label for="login_email">Введите email, который вы указывали при регистрации</label>
			<div>
				<div class="input-group">
					<span class="input-group-addon"><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span></span>
					<input placeholder="Email" type="email" class="form-control" id="login_email" name="email" required maxlength="255" value="{$email|escape}">
				</div>
				{if $error}{if $error=='user_not_found'}
					<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
					<span class="sr-only">(ошибка)</span>
				{else}
					<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
					<span class="sr-only">(верно)</span>
				{/if}{/if}
			</div>
		</div>
		<small class="pull-right help-block">Все поля обязательны для заполнения</small>
		<button type="submit" class="btn btn-primary">Вспомнить</button>
	{/if}
</form>
