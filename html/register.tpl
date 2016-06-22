{$meta_title="Регистрация" scope=parent}{$meta_robots="noindex, nofollow, noarchive" scope=parent}
<nav>
	<ol class="breadcrumb">
		<li><a href="/">Главная</a></li>
		<li><a href="/user">Пользователь</a></li>
		<li class="active">Регистрация</li>
	</ol>
	<ul class="nav nav-tabs">
		<li><a href="/user/login">Вход</a></li>
		<li class="active"><a href="/user/register">Регистрация</a></li>
		<li><a href="/user/password_remind">Напомнить пароль</a></li>
	</ul>
</nav>
<form enctype="multipart/form-data" method="post" id="user" class="form well well-top" action="/user/register">
	{if $error}<div class="well"><span class="text-danger">
		<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
		{if $error=='empty_name'}Введите имя{elseif $error == 'empty_email'}Введите email{elseif $error=='empty_password'}Введите пароль{elseif $error=='user_exists'}Пользователь с таким email уже зарегистрирован{elseif $error=='captcha'}Неверно введена капча{else}{$error}{/if}
	</span></div>{/if}
	<div class="form-group{if $error} {if $error=='empty_name'}has-error has-feedback{else}has-success has-feedback{/if}{/if}">
		<label class="sr-only" for="register_name">Имя</label>
		<div>
			<div class="input-group">
				<span class="input-group-addon"><span class="glyphicon glyphicon-user" aria-hidden="true"></span></span>
				<input placeholder="Имя" type="text" class="form-control" id="register_name" name="name" pattern="^[А-Яа-яЁё\s]+$" required maxlength="255" value="{$name|escape}">
			</div>
			{if $error}{if $error=='empty_name'}
				<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
				<span class="sr-only">(ошибка)</span>
			{else}
				<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
				<span class="sr-only">(верно)</span>
			{/if}{/if}
		</div>
	</div>
	<div class="form-group{if $error} {if $error=='empty_email' || $error=='user_exists'}has-error has-feedback{elseif $error!='empty_name'}has-success has-feedback{/if}{/if}">
		<label class="sr-only" for="register_email">Email</label>
		<div>
			<div class="input-group">
				<span class="input-group-addon"><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span></span>
				<input placeholder="Email" type="email" class="form-control" id="register_email" name="email" required maxlength="255" value="{$email|escape}">
			</div>
			{if $error}{if $error=='empty_email' || $error=='user_exists'}
				<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
				<span class="sr-only">(ошибка)</span>
			{elseif $error!='empty_name'}
				<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
				<span class="sr-only">(верно)</span>
			{/if}{/if}
		</div>
	</div>
	<div class="form-group{if $error} {if $error=='empty_password'}has-error has-feedback{elseif $error!='empty_email' && $error!='user_exists' && $error!='empty_name'}has-success has-feedback{/if}{/if}">
		<label class="sr-only" for="register_password">Пароль</label>
		<div>
			<div class="input-group">
				<span class="input-group-addon"><span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span></span>
				<input placeholder="Пароль" type="password" class="form-control" id="register_password" name="password" pattern=".+" required value="">
			</div>
			{if $error}{if $error=='empty_password'}
				<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
				<span id="inputError2Status" class="sr-only">(ошибка)</span>
			{elseif $error!='empty_email' && $error!='user_exists' && $error!='empty_name'}
				<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
				<span class="sr-only">(верно)</span>
			{/if}{/if}
		</div>
	</div>
	<div class="form-group{if $error && $error=='captcha'} has-error has-feedback{/if}">
		<label for="deliveries_captcha_code" class="sr-only">Капча</label>
		<div class="input-group form-group-lg">
			<span class="input-group-addon capcha"><span style="background-image: url(/captcha/image.php?{math equation='rand(10,10000)'});"></span></span>
			<input class="form-control" id="deliveries_captcha_code" name="captcha_code" type="text" value="" data-format="\d\d\d\d" required placeholder="Введите капчу">
		</div>
		{if $error && $error=='captcha'}
			<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
			<span class="sr-only">(ошибка)</span>
		{/if}
	</div>
	<small class="pull-right help-block">Все поля обязательны для заполнения</small>
	<input type="submit" class="btn btn-primary" name="register" value="Зарегистрироваться">
</form>
