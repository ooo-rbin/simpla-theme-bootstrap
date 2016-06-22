<?php
session_start();
require_once '../../api/Simpla.php';
$simpla = new Simpla();
// Возможные пременные
$product_id = $simpla->request->get('product', 'integer');
$variant_id = $simpla->request->get('variant', 'integer');
$amount = $simpla->request->get('amount', 'integer');
if ($variant_id) {
	$simpla->cart->add_item($variant_id, $amount);
} elseif ($product_id) {
	$simpla->cart->add_request($product_id, $amount);
}
$cart = $simpla->cart->get_cart();
$simpla->design->assign('cart', $cart);
$currencies = $simpla->money->get_currencies(array('enabled'=>1));
if (isset($_SESSION['currency_id'])) {
	$currency = $simpla->money->get_currency($_SESSION['currency_id']);
} else {
	$currency = reset($currencies);
}
$simpla->design->assign('currency',	$currency);
$result = $simpla->design->fetch('cart_informer.tpl');
header("Content-type: application/json; charset=UTF-8");
header("Cache-Control: must-revalidate");
header("Pragma: no-cache");
header("Expires: -1");		
print json_encode($result);
