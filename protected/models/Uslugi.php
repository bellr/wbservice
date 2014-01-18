<?
class Uslugi extends Model {

    public $prop;

    //Заголовки для разделов
    public static $category = array(
        'Communication'=>'Услуги связи',
        'Internet'=>'Интернет-провайдеры',
        'TV'=>'Телевидение',
        'Komunal'=>'Коммунальные услуги',
        'Banking'=>'Банковские услуги');

    public function get($SqlParam) {

        $res = dataBase::DBpaydesk()->select('uslugi','*',dataBase::where($SqlParam));

        return $res[0];
    }

    public static function detectDelay($account) {
        $uslugi = Model::Uslugi()->getStaticData('uslugi','form','Delay');

        if(strlen($account) == 7) $id = 0;
        elseif(strlen($account) == 8) $id = 1;

        return $uslugi['Delay']['alias'][$id]['name'];
    }
}
