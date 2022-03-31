import {LightningElement, api, wire, track} from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import {refreshApex} from "@salesforce/apex"; // LWC function
import {ShowToastEvent} from 'lightning/platformShowToastEvent'; // LWC feedback windows
import TODO_OBJECT from '@salesforce/schema/Todo__c';
import NAME_FIELD from '@salesforce/schema/ToDo__c.Name';
import DESCRIPTION_FIELD from '@salesforce/schema/ToDo__c.Description__c';
import CREATIONDATE_FIELD from '@salesforce/schema/ToDo__c.Creation_Date__c';
import CATEGORY_FIELD from '@salesforce/schema/ToDo__c.Category__c';
import PRIORITY_FIELD from '@salesforce/schema/ToDo__c.Priority__c';
import STATUS_FIELD from '@salesforce/schema/ToDo__c.Status__c';

export default class EditItem extends LightningElement {

    @api isOpen; // for lightning-record-form
    @api item; // for lightning-record-form
    

    fields = [
        NAME_FIELD,PRIORITY_FIELD, DESCRIPTION_FIELD, 
        CREATIONDATE_FIELD, CATEGORY_FIELD, STATUS_FIELD
    ];

    handleSuccess(event) {
        return refreshApex(this.wiredResult);
    }
    handleSubmit(event) {
        return refreshApex(this.wiredResult);
    }

    handleSave(){
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
        this.dispatchEvent(new CustomEvent('closemodal')); // send event for update list
    }

    @track selectedRecordTypeId;
    @track options;

    handleChangeRecordType(event) {
        this.selectedRecordTypeId = event.detail.value;
    }

    @wire(getObjectInfo, {objectApiName: TODO_OBJECT})
    todoObjectInfo({data, error}){
        if(data){
            let optionsValues = [];
            const recordTypeInfos = data.recordTypeInfos;
            let recordTypeValues = Object.values(recordTypeInfos);
            for(let i = 0; i < recordTypeValues.length; i++){
                if(recordTypeValues[i].name !== 'Master'){
                    optionsValues.push({
                        label : recordTypeValues[i].name,
                        value : recordTypeValues[i].recordTypeId
                    })
                }
            }
            this.options = optionsValues;
        }
    }
}