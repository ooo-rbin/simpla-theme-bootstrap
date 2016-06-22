{if $cart->total_products>0}
	{$cart->total_products} {$cart->total_products|plural:'товар':'товаров':'товара'}<span class="clearfix hidden-print"></span>
	<small><span class="hidden visible-print-inline">на сумму</span> {assign var='cart_summ' value=','|explode:($cart->total_price|convert)}{$cart_summ.0} {$currency->sign|escape}</small>
{else}
	пусто
{/if}
