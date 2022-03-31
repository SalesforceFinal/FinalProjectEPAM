import {LightningElement, wire, track, api} from 'lwc';
import getItems from '@salesforce/apex/ToDoListController.getItems';
import getFailedItems from '@salesforce/apex/ToDoListController.getItems';
import getCompletedItems from '@salesforce/apex/ToDoListController.getItems';
import searchItems from '@salesforce/apex/ToDoListController.searchItems';
import {ShowToastEvent} from 'lightning/platformShowToastEvent'; // LWC feedback windows
import {deleteRecord} from "lightning/uiRecordApi"; // Wire Service function
import {refreshApex} from "@salesforce/apex"; // LWC function
import {reduceErrors} from 'c/errors';

export default class todoList extends LightningElement {


  
  key = ''; // search field value
  @track items;
  item = {"Id" : null};
  wiredResult;
  isOpenWindow = false; // for show and hide modal window
  @track isEmpty = true; // for empty list handling
  
  // Pagination
  visibleItems;
  updateItemPaginator(event){
    this.visibleItems=[...event.detail.itemspaginator];
    return refreshApex();
  }
  
  // show list with empty search
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

  // show list with search value
  @wire(searchItems, {searchKey: '$key'})
  wiredItem({error, data}) {
    if (data) {
      this.items = data;
      this.error = undefined;
    } else if (error) {
      this.error = error;
      this.items = undefined;
    }
    return refreshApex(this.wiredResult);
  }

  // key gets value of search field
  handleUpdateKey(event) {
    this.key = event.target.value;
    return refreshApex(this.wiredResult);
  }

  handleDeleteItem(event) {
    const itemId = event.detail;
    deleteRecord(itemId) // imported wire Service function
    .then(() => {
      this.dispatchEvent(
          new ShowToastEvent({
            title: 'Deleted',
            message: 'Item deleted',
            variant: 'warning'
          })
      );
      return refreshApex(this.wiredResult);
    })
    .catch((error) => {
      console.log('hello');
      this.dispatchEvent(
          new ShowToastEvent({
            title: 'Error deleting',
            message: reduceErrors(error).join(', '),
            variant: 'error'
          })
      );
    });
  }

  updateItems() {
    return refreshApex(this.wiredResult);
  }

  // for create button
  handleUpsertItem() {
    this.isOpenWindow = true;
  }

  // for close modal window
  handleCloseWindow() {
    this.isOpenWindow = false;
    return this.updateItems();
  }
}