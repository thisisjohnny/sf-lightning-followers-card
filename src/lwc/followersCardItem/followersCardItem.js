import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class FollowersCardItem extends NavigationMixin(LightningElement) {
    @api
    follower;

    get followerInitials(){
        const firstInitial = this.follower.FirstName.substring(0, 1);
        const lastInitial = this.follower.LastName.substring(0, 1);
        const initials = (firstInitial + lastInitial).toUpperCase();

        return initials;
    }

    get imageUrl(){
        const profilePhoto = this.follower.MediumPhotoUrl;          // get photo url from user record
        const pos = profilePhoto.search("profilephoto/005/M");      // returns -1 if default icon
        if ( pos == -1 ){
            return profilePhoto;
        } else {
            return '';
        }
    }

    navigateToUser(event){
        event.preventDefault();
        const userId = this.follower.Id;

        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: userId,
                objectApiName: 'User',
                actionName: 'view'
            }
        });
    }
}