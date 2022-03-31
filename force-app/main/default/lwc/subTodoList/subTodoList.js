import {LightningElement, api, track, wire} from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent'; // LWC feedback windows
import {deleteRecord} from "lightning/uiRecordApi"; // Wire Service function
import {refreshApex} from "@salesforce/apex"; // LWC function
import getItems from '@salesforce/apex/ToDoListController.getItems';
import NAME_FIELD from '@salesforce/schema/Sub_ToDo__c.Name';
import ISDONE_FIELD from '@salesforce/schema/Sub_ToDo__c.isDone__c';
import TODO_FIELD from '@salesforce/schema/Sub_ToDo__c.ToDo__c';

export default class SubTodoList extends LightningElement {

  @api item;
  @api recordId;
  @api isOpen; // for lightning-record-form
  @track items;
  wiredResult;
  @track isEmpty = true;

  fields = [
    NAME_FIELD,TODO_FIELD, ISDONE_FIELD
];

  isOpenWindow = false;
  isOpenEditWindow = false;
  isOpenViewWindow = false;

  handleSubmitButtonClick(){       
    this.template.querySelector('lightning-record-edit-form').submit();
 }

  handleClickEdit() { // open modal window
    this.isOpenEditWindow = true;
  }

  handleUpsertItem() {
    this.isOpenWindow = true;
  }

  visibleItems;
  updateItemPaginator(event){
    this.visibleItems=[...event.detail.itemspaginator];
    return refreshApex();
  }

  @wire(getItems)
  getList(result) {
    this.wiredResult = result;
    if (result.data) {
      this.items = result.data;
      this.isEmpty = result.data.length === 0 ? true: false; // empty list handling 
      this.error = undefined;
    } else if (result.error) {
      this.error = result.error;
      this.items = undefined;
    }
  }

  deleteSubToDo(event) {
    const recordSubToDoId = event.target.dataset.recordid;
    console.log('!!!!!!!ID DELETING SUBTODO!!!!! = ' + recordSubToDoId);
    deleteRecord(recordSubToDoId)
     .then(() => {
       this.dispatchEvent(
         new ShowToastEvent({
          title: 'Deleted',
          message: 'SubToDo deleted',
          variant: 'warning'
        })
      )
       return refreshApex(this.wiredResult);
     })
     .catch((error) => {
       this.dispatchEvent(
         new ShowToastEvent({
          title: 'Error deleting',
          message: 'Error',
          variant: 'error'
        })
      )
  });
}

  closeEditModal() { // close modal window and update list
    this.isOpenEditWindow = false;
  }

  closeViewModal() {
    this.isOpenViewWindow = false;
    this.dispatchEvent(new CustomEvent('updatelist'));
  }

    handleSuccess(event) {
        return refreshApex(this.wiredResult);
    }
    handleSubmit(event) {
        return refreshApex(this.wiredResult);
    }

    handleSave(){
        this.isOpenEditWindow = false;
        this.isOpenWindow = false;
        this.dispatchEvent(new CustomEvent('closemodal')); // send event for update list
        this.dispatchEvent(
            new ShowToastEvent({
            title: 'Success',
            message: 'ToDo created',
            variant: 'success'
          }));
        return refreshApex(this.wiredResult); 
    }

    handleCancel(){
      this.isOpenEditWindow = false;
    }

    closeCreateModal() {
      this.isOpenWindow = false;
    }
}