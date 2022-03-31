import {LightningElement, api, track, wire} from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import updateOwner from '@salesforce/apex/ToDoListController.getItems';
import Id from '@salesforce/user/Id';
import NAME_FIELD from "@salesforce/schema/ToDo__c.Name";
import DESCRIPTION_FIELD from "@salesforce/schema/ToDo__c.Description__c";
import CATEGORY_FIELD from "@salesforce/schema/ToDo__c.Category__c";
import STATUS_FIELD from "@salesforce/schema/ToDo__c.Status__c";
import PRIORITY_FIELD from "@salesforce/schema/ToDo__c.Priority__c";
import SUB_NAME_FIELD from "@salesforce/schema/Sub_ToDo__c.Name";
import SUB_STATUS_FIELD from "@salesforce/schema/Sub_ToDo__c.isDone__c";
import OWNER_FIELD from "@salesforce/schema/ToDo__c.OwnerId";

export default class todoItem extends LightningElement {

  fields = [
    NAME_FIELD,
    DESCRIPTION_FIELD,
    CATEGORY_FIELD,
    PRIORITY_FIELD,
    STATUS_FIELD,
    OWNER_FIELD
];

fieldsSub = [
  SUB_STATUS_FIELD,
  SUB_NAME_FIELD
];

userId = Id;

  @api item;
  @api recordId;
  @track items;
  @track isEmpty = true;
  @track idForOwner;

  

  isOpenEditWindow = false;
  isOpenViewWindow = false;

  handleClickEdit() { // open modal window
    this.isOpenEditWindow = true;
  }

  handleTakeTodo() {
    const updateOwner = new CustomEvent('updated', {
      detail: this.item.Id
    });
    this.dispatchEvent(updateOwner);
    updateOwner({idOwner: this.userId, recordId: this.item.Id});
    console.log(this.userId);
    console.log(this.item.Id);
  }

  handleClickView(event) {
    event.preventDefault();
    this.isOpenViewWindow = !this.isOpenViewWindow;
    const selectedTodo = new CustomEvent('selected', { 
      detail: this.item.Id 
    });
    this.dispatchEvent(selectedTodo);
  }

  handleClickDelete() {
    console.log('Delete from list: ' + this.item.Id)
    const deleteEvent = new CustomEvent('deleteitem', {
      detail: this.item.Id
    });
    this.dispatchEvent(deleteEvent);
  }

  closeEditModal() { // close modal window and update list
    this.isOpenEditWindow = false;
    this.dispatchEvent(new CustomEvent('updatelist'));
  }

  closeViewModal() {
    this.isOpenViewWindow = false;
    this.dispatchEvent(new CustomEvent('updatelist'));
  }
}