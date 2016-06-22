{if $total_pages_num > 1}
	<nav>
		<ul class="pagination">
{$visible_pages=7}{$page_from=1}{if $current_page_num>floor($visible_pages/2)}{$page_from=max(1,$current_page_num-floor($visible_pages/2)-1)}{/if}{if $current_page_num>$total_pages_num-ceil($visible_pages/2)}{$page_from=max(1,$total_pages_num-$visible_pages-1)}{/if}{$page_to=min($page_from+$visible_pages,$total_pages_num-1)}{if $current_page_num==2}<li><a id="prev_page_link" aria-label="Предыдущая" href="{url page=null}"><span><span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span></span></a></li>{elseif $current_page_num>2}<li><a id="prev_page_link" aria-label="Предыдущая" href="{url page=$current_page_num-1}"><span><span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span></span></a></li>{else}<li class="disabled"><span><span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span></span></li>{/if}
			<li{if $current_page_num==1} class="active disabled"{/if}>{if $current_page_num!=1}<a href="{url page=null}">{/if}<span>1</span>{if $current_page_num!=1}</a>{/if}</li>
			{section name=pages loop=$page_to start=$page_from}{$p=$smarty.section.pages.index+1}{if ($p==$page_from+1 && $p!=2) || ($p==$page_to && $p!=$total_pages_num-1)}
				<li {if $p==$current_page_num}class="active disabled"{/if}>{if $p!=$current_page_num}<a href="{url page=$p}">{/if}<span><span class="glyphicon glyphicon-option-horizontal" aria-hidden="true"></span></span>{if $p!=$current_page_num}</a>{/if}</li>
			{else}
				<li {if $p==$current_page_num}class="active disabled"{/if}>{if $p!=$current_page_num}<a href="{url page=$p}">{/if}<span>{$p}</span>{if $p!=$current_page_num}</a>{/if}</li>
			{/if}{/section}
			<li {if $current_page_num==$total_pages_num}class="active disabled"{/if}>{if $current_page_num!=$total_pages_num}<a href="{url page=$total_pages_num}">{/if}<span>{$total_pages_num}</span>{if $current_page_num!=$total_pages_num}</a>{/if}</li>
			{if $current_page_num<$total_pages_num}<li><a id="next_page_link" aria-label="Следующая" href="{url page=$current_page_num+1}"><span><span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span></span></a></li>{else}<li class="disabled"><span><span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span></span></li>{/if}
		</ul>
		<ul class="pagination">
			<li><a href="{url page=all}"><span>Все сразу</span></a></li>
		</ul>
	</nav>
{/if}
