<?
class header_widget extends Template {
    function __construct($action_method,$vars='') {

        $this->$action_method();
    }

    private function block() {

        $this->vars['header'] = Vitalis::tmpl('Widgets')->load_tmpl_block('inc.header');

        return $this->vars;
    }
}

?>