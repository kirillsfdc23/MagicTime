/**
 * Created by Kirill.Kravchenko on 18.04.2020.
 */
public class JSONDeserialize {

    public void deserialize() {
        Http h = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint('https://bitpay.com/api/rates/');
        request.setHeader('Content-type', 'application/json');
        request.setMethod('GET');

        HttpResponse response = h.send(request);

        if (response.getStatusCode() == 200) {

            List<BitcoinWrapper> results =
                    (List<BitcoinWrapper>)
                            JSON.deserialize(response.getBody(), BitcoinWrapper.class);

            System.debug(results);
        }
    }
}