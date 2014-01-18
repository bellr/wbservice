<?
class menu_widget extends Template {

    public  function block() {
        $this->vars['menu'] = Vitalis::tmpl('Widgets')->load_tmpl_block('inc.menu');
        return $this;
    }
}

?>