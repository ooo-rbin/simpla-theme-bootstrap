{$meta_robots="noindex, nofollow, noarchive" scope=parent}
<nav>
	<ol class="breadcrumb">
		<li><a href="/">Главная</a></li>
		<li class="active">Пользователь</li>
	</ol>
</nav>
<form enctype="multipart/form-data" method="post" id="user" class="form well" action="/user">
	<h3>Настройки аккаунта</h3>
	{if $error}
		<div class="well"><span class="text-danger">
			<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
			{if $error == 'empty_name'}Введите имя
			{elseif $error == 'empty_email'}Введите email
			{elseif $error == 'empty_password'}Введите пароль
			{elseif $error == 'user_exists'}Пользователь с таким email уже зарегистрирован
			{else}{$error}{/if}
		</span></div>
	{/if}
	<div class="form-group{if $error} {if $error=='empty_name'}has-error has-feedback{else}has-success has-feedback{/if}{/if}">
		<label class="sr-only" for="user_name">Имя</label>
		<div>
			<div class="input-group">
				<span class="input-group-addon"><span class="glyphicon glyphicon-user" aria-hidden="true"></span></span>
				<input placeholder="Имя" type="text" class="form-control" id="user_name" name="name" pattern="^[А-Яа-яЁё\s]+$" required maxlength="255" value="{$name|escape}">
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
		<label class="sr-only" for="user_email">Email</label>
		<div>
			<div class="input-group">
				<span class="input-group-addon"><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span></span>
				<input placeholder="Email" type="email" class="form-control" id="user_email" name="email" required maxlength="255" value="{$email|escape}">
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
		<label class="sr-only" for="user_password">Пароль</label>
		<div>
			<div class="input-group">
				<span class="input-group-addon"><span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span></span>
				<input placeholder="Пароль" type="password" class="form-control togglet" id="user_password" name="password" pattern=".+" value="">
				<label for="user_password" class="form-control btn btn-default toggle" data-toggle-class="up form-control input-group-addon">
					<span class="toggle-show">
						<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
						<span class="sr-only">Отменить изменение пароля</span>
					</span>
					<span class="toggle-hidden">Изменить пароль</span>
				</label>
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
	<small class="pull-right help-block">Все поля обязательны для заполнения</small>
	<input type="submit" class="btn btn-primary" value="Сохранить">
</form>
{if $orders}
	<h2>Ваши заказы</h2>
	<nav id="orders" class="list-group">
		{foreach $orders as $order}
			<a class="list-group-item{if $order->status==0} list-group-item-warning{elseif $order->status==1}list-group-item-info{elseif $order->status==2}list-group-item-success{/if}" href="order/{$order->url}">
				<h3>Заказ №{$order->id} <small>{$order->date|date}</small> <span class="badge">{if $order->status==0}<span class="glyphicon glyphicon-hourglass" aria-hidden="true"></span> Ждет обработки{elseif $order->status==1}<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span> В обработке{elseif $order->status==2}<span class="glyphicon glyphicon-ok" aria-hidden="true"></span> Выполнен{/if}</span> <span class="badge">{if $order->paid==1}<span class="glyphicon glyphicon-ok" aria-hidden="true"></span> Оплачено{else}<span class="glyphicon glyphicon-remove" aria-hidden="true"></span> Не оплачено{/if}</span></h3>
				{if $order->note}<p>{$order->note|escape}</p>{/if}
			</a>
		{/foreach}
	</nav>
{/if}
