import { LightningElement, api, wire, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getFollowers from '@salesforce/apex/FollowersController.getFollowers';

export default class FollowersCard extends LightningElement {
    @api recordId;

    @wire(getFollowers, { recordId: '$recordId' })
    followers

    get listSize(){
        if ( this.followers != null && this.followers.data != null ){
            return this.followers.data.length;
        } else {
            return 0;
        }
    }

    get followersExist(){
        return (this.followers != null) ? true : false;
    }

    handleRefresh(){
        return refreshApex(this.followers);
    }
}