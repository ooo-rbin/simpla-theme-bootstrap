<nav>
	<ol class="breadcrumb">
		<li><a href="/">Главная</a></li>
		<li class="active">{$page->name}</li>
	</ol>
</nav>
<h1>{$page->name}</h1>
{foreach $posts as $post}
	{if $post->text}
		<article class="panel panel-default">
			<h2 class="panel-heading panel-title">
				<a data-post="{$post->id}" href="blog/{$post->url}">
					{$post->name|escape}
					<!--noindex--><span class="badge pull-right">подробнее...</span><!--/noindex-->
				</a>
			</h2>
			<div class="panel-body">{$post->annotation}</div>
		</article>
	{else}
		<article class="panel panel-info">
			<h2 class="panel-heading panel-title">
				<span data-post="{$post->id}">
					{$post->name|escape}
					<!--noindex--><span class="badge pull-right">Акция!</span><!--/noindex-->
				</span>
			</h2>
			<div class="panel-body">{$post->annotation}</div>
		</article>
	{/if}
{/foreach}
<p class="text-right"><span class="text-nowrap">Поделиться в соцсетях</span> <span class="pluso" data-background="#ebebeb" data-options="small,round,line,horizontal,nocounter,theme=04" data-services="vkontakte,odnoklassniki,facebook,twitter,google,moimir,email,print"></span></p>
{include file='pagination.tpl'}
