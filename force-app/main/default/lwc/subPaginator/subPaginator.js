import { LightningElement, api, track} from 'lwc';
export default class SubPaginator extends LightningElement {
    
    totalItems;
    totalPage = 0;
    @track currentPage = 1;
    itemSize = 5;
    @track wiredResult;

    get itemspaginator() {
        return this.visibleItems;
    }

    @api set itemspaginator(data) {
        if(data) {   
            this.totalItems = data;
            console.log(this.totalItems.length);
            this.totalPage = Math.ceil(data.length / this.itemSize);
            this.updateItemsPaginator();
        }
    }
    
    updateItemsPaginator() {
        const startItem = (this.currentPage - 1) * this.itemSize;
        const endItem = this.itemSize * this.currentPage;
        this.visibleItems = this.totalItems.slice(startItem, endItem);
        this.dispatchEvent(new CustomEvent('update', { // send event for update list visible items
            detail:{ 
                itemspaginator:this.visibleItems
            }
        }));
    }
}