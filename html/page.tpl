<nav>
	<ol class="breadcrumb">
		<li><a href="/">Главная</a></li>
		<li class="active">{$page->name}</li>
	</ol>
</nav>
<h1><span data-page="{$page->id}">{$page->header|escape}</span></h1>
{$page->body}
<p class="text-right"><span class="text-nowrap">Поделиться в соцсетях</span> <span class="pluso" data-background="#ebebeb" data-options="small,round,line,horizontal,nocounter,theme=04" data-services="vkontakte,odnoklassniki,facebook,twitter,google,moimir,email,print"></span></p>
