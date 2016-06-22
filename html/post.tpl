{if !$post->text}{$meta_robots="noindex, nofollow, noarchive" scope=parent}{/if}
<nav>
	<ol class="breadcrumb">
		<li><a href="/">Главная</a></li>
		<li><a href="/blog">Акции</a></li>
		<li class="active">{$post->name|escape}</li>
	</ol>
</nav>
<h1><span data-post="{$post->id}"><small>{$post->date|date}</small> {$post->name|escape}</span></h1>
{$post->text}
<p class="text-right"><span class="text-nowrap">Поделиться в соцсетях</span> <span class="pluso" data-background="#ebebeb" data-options="small,round,line,horizontal,nocounter,theme=04" data-services="vkontakte,odnoklassniki,facebook,twitter,google,moimir,email,print"></span></p>
{if $prev_post || $next_post}
	<hr>
	<nav id="nearby">
		<ul class="pager row">
			{if $prev_post}
				<li class="previous col-xs-6"><a title="Ctr + ←" id="prev_page_link" href="/blog/{$prev_post->url}"><span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> {$prev_post->name|escape}</a></li>
			{/if}
			{if $next_post}
				<li class="next col-xs-6{if !$prev_post} col-xs-offset-6{/if}"><a title="Ctr + →" id="next_page_link" href="/blog/{$next_post->url}">{$next_post->name|escape} <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span></a></li>
			{/if}
		</ul>
	</nav>
{/if}
<div id="comments" class="panel panel-default">
	<h2 class="panel-heading">Комментарии</h2>
	{if $comments}
		<ul class="list-group">
			{foreach $comments as $comment}
				<li class="list-group-item comment" id="comment_{$comment->id}">
					<h3 class="list-group-item-heading">{$comment->name|escape} <small>{$comment->date|date}, {$comment->date|time}</small>{if !$comment->approved} <span class="badge">Ожидает модерации</span>{/if}</h3>
					<blockquote class="list-group-item-text">{$comment->text|escape|nl2br}</blockquote>
				</li>
			{/foreach}
		</ul>
	{else}
		<p class="panel-body">Пока нет комментариев</p>
	{/if}
	<form id="addcomment" class="form panel-footer" method="post">
		<h3>Написать комментарий</h3>
		{if $error}
			<div class="well"><span class="text-danger">
				<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				{if $error=='captcha'}Неверно введена капча
				{elseif $error=='empty_name'}Введите имя
				{elseif $error=='empty_comment'}Введите комментарий
				{/if}
			</span></div>
		{/if}
		<div class="form-group{if $error} {if $error=='empty_name'}has-error has-feedback{elseif $error!='captcha'}has-success has-feedback{/if}{/if}">
			<label class="sr-only" for="comment_name">Имя</label>
			<div>
				<div class="input-group">
					<span class="input-group-addon"><span class="glyphicon glyphicon-user" aria-hidden="true"></span></span>
					<input placeholder="Имя" type="text" class="form-control" id="comment_name" name="name" pattern="^[А-Яа-яЁё\s]+$" required maxlength="32" value="{$comment_name|escape}">
				</div>
				{if $error}{if $error=='empty_name'}
					<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
					<span class="sr-only">(ошибка)</span>
				{else $error!='captcha'}
					<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
					<span class="sr-only">(верно)</span>
				{/if}{/if}
			</div>
		</div>
		<div class="form-group{if $error && $error=='empty_comment'}has-error has-feedback{/if}">
			<label class="sr-only" for="comment_text">Коментарий</label>
			<div>
				<div class="input-group">
					<span class="input-group-addon" style="vertical-align: top;"><span class="glyphicon glyphicon-bullhorn" aria-hidden="true"></span></span>
					<textarea placeholder="Коментарий" class="form-control" id="comment_text" rows="7" name="text" required pattern=".+" maxlength="1024">{$comment_text}</textarea>
				</div>
				{if $error}{if $error=='empty_name'}
					<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
					<span class="sr-only">(ошибка)</span>
				{else $error!='captcha'}
					<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
					<span class="sr-only">(верно)</span>
				{/if}{/if}
			</div>
		</div>
		<div class="form-group{if $error && $error=='captcha'} has-error has-feedback{/if}">
			<label for="comment_captcha_code" class="sr-only">Капча</label>
			<div class="input-group form-group-lg">
				<span class="input-group-addon capcha"><span style="background-image: url(/captcha/image.php?{math equation='rand(10,10000)'});"></span></span>
				<input class="form-control" id="comment_captcha_code" name="captcha_code" type="text" value="" data-format="\d\d\d\d" required placeholder="Введите капчу">
			</div>
			{if $error && $error=='captcha'}
				<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
				<span class="sr-only">(ошибка)</span>
			{/if}
		</div>
		<small class="pull-right help-block">Все поля обязательны для заполнения</small>
		<input type="submit" class="btn btn-primary" name="comment" value="Отправить">
	</form>
</div>
