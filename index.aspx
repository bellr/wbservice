<?

define('PROJECT','SERVICE');
define('PROJECT_ROOT',dirname(__FILE__));
define('VS_DEBUG',true);

require_once(dirname(PROJECT_ROOT)."/core/vs.php");

Vitalis::Router();