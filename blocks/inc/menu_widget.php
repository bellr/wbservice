<?
class menu_widget extends Template {
    function __construct($action_method,$vars='') {
        $this->$action_method();
    }

    private function block() {
        $this->vars['menu'] = Vitalis::tmpl('Widgets')->load_tmpl_block('inc.menu');
        return $this->vars;
    }
}

?>