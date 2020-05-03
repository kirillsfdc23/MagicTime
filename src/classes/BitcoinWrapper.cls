/**
 * Created by Kirill.Kravchenko on 18.04.2020.
 */

public with sharing class BitcoinWrapper {

    public class bitcoinValue {
        public String code { get; set; }
        public String name { get; set; }
        public Double rate { get; set; }
    }
    public List<bitcoinValue> bitcoinList {get; set;}
}