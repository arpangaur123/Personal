import { LightningElement, api } from 'lwc';

export default class LocationDetails extends LightningElement {

  @api placeInfo;

  city = "";
  locality = "";
  state = "";
  country = "";


  connectedCallback() {
    const placeInfo = JSON.parse(JSON.stringify(this.placeInfo));
    this.city = placeInfo.city;
    this.locality = placeInfo.locality;
    this.state = placeInfo.state;
    this.country = placeInfo.country;
  }

}