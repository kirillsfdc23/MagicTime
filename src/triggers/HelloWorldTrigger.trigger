/**
 * Created by Kirill.Kravchenko on 04.04.2020.
 */

trigger HelloWorldTrigger on Lead (before update) {
      for (Lead lead: Trigger.new) {
          lead.FirstName = 'Kirill';
          lead.LastName  = 'Kravchenko';
      }
}