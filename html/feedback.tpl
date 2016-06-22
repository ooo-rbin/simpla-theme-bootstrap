<nav>
	<ol class="breadcrumb">
		<li><a href="/">Главная</a></li>
		<li class="active">{$page->name}</li>
	</ol>
</nav>
<h1>{$page->name|escape}</h1>
{$page->body}
<form enctype="multipart/form-data" action="/design/{$settings->theme}/mailer.php" method="post" id="feedback" class="form well">
	<h3>Обратная связь</h3>
	{if $smarty.session.feedback_result && $smarty.session.feedback_result.valid>$smarty.now}<div class="well">
		{$smarty.session.feedback_result.message}{assign var='mailer_name' value="{$smarty.session.feedback_result.name}"}{assign var='mailer_phone' value="{$smarty.session.feedback_result.phone}"}{assign var='mailer_text' value="{$smarty.session.feedback_result.text}"}
	</div>{/if}
	<div class="form-group">
		<label for="feedback_name" class="sr-only">Имя</label>
		<div class="input-group">
			<span class="input-group-addon"><span class="glyphicon glyphicon-user" aria-hidden="true"></span></span>
			<input placeholder="Имя" type="text" class="form-control" id="feedback_name" name="name" required pattern="^[А-Яа-яЁё\s]+$" maxlength="32" value="{$mailer_name|escape}">
		</div>
	</div>
	<div class="form-group">
		<label for="feedback_phone" class="sr-only">Телефон</label>
		<div class="input-group">
			<span class="input-group-addon"><span class="glyphicon glyphicon-phone" aria-hidden="true"></span></span>
			<input placeholder="Телефон" type="text" class="form-control" id="feedback_phone" name="phone" required pattern="^[\d\s\+\-\(\)]+$" maxlength="32" value="{$mailer_phone|escape}">
		</div>
	</div>
	<div class="form-group">
		<label for="feedback_text" class="sr-only">Сообщение</label>
		<div class="input-group">
			<span class="input-group-addon" style="vertical-align: top;"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
			<textarea required rows="5" placeholder="Сообщение" class="form-control" id="feedback_text" name="text">{$mailer_text|escape}</textarea>
		</div>
	</div>
	{if $smarty.session.mailer_signature}{assign var='mailer_sign' value="{$config->root_url}{$smarty.server.REQUEST_URI}{$smarty.session.mailer_signature}"}{else}{assign var='mailer_sign' value="{$config->root_url}{$smarty.server.REQUEST_URI}{$smarty.cookies.PHPSESSID}"}{/if}<input type="hidden" name="sign" value="{$mailer_sign|md5}">
	<input type="hidden" name="tpl" value="feedback">
	<button type="submit" class="btn btn-default pull-right">Отправить сообщение</button>
	<div class="clearfix"></div>
</form>
