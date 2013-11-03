<?
define('VS_DEBUG',true);
$project = isset($_GET['object']) ? $_GET['object'] : $_POST['object'];
define('PROJECT',strtoupper($project));

require_once(dirname($_SERVER['DOCUMENT_ROOT'])."/core/vs.php");

Vitalis::Router();