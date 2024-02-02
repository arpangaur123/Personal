import { LightningElement, track } from 'lwc';
export default class Path_nev extends LightningElement {
    @track items = [
        { id: 1, value: 'Item 1' },
        { id: 2, value: 'Item 2' },
        { id: 3, value: 'Item 3' }
    ];
    selectedpiclistvalue;


    handlestageValue() {
        console.log('inhandle');
        let picval = event.currentTarget.dataset.value;
        this.selectedpiclistvalue = picval;
        this.cssSelectPathMethod();
        let targetIds = event.currentTarget.id;
        this.template.querySelector("[id=" + targetIds + "]").className = 'slds-is-active slds-path__item';
        console.log('targetId', targetIds);
    }
    cssSelectPathMethod() {
        // console.log('currentstage',this.currentstage);
        const curstge = this.selectedpiclistvalue;
        //    console.log('curstge',curstge);
        var val = this.template.querySelectorAll('.slds-path__item'), i;
        //  console.log('val',val.length,val);
        let completemark;
        for (i = 0; i < val.length; ++i) {
            let stagevalue = String(curstge).substr(0, 4);
            //   console.log('stagevalue',String(curstge).substr(0, 4));
            // console.log('stagevalue',String(val[i].id).substr(0, 4));
            if (curstge != 'Item 1') {
                if (String(curstge).substr(0, 4) == String(val[i].id).substr(0, 4)) {
                    //     console.log('equal');
                    val[i].className = 'slds-is-active slds-path__item';
                    completemark = i;

                }
            }
            else {
                if (String(curstge).substr(1, 2) == String(val[i].id).substr(1, 2)) {
                    val[i].className = 'slds-is-active slds-path__item';
                    completemark = i;
                }
            }
            //  console.log('val[i].id.className',val[i].className);
            //console.log('hsh',val[i].id);
            //console.log('hsh',val[i]);
        }
        for (let j = completemark - 1; j >= 0; j--) {
            val[j].className = 'slds-is-complete slds-path__item'
        }
        // console.log('completemark ',completemark, 'prevselect ',this.prevselect);  
        if (this.prevselect > completemark) {
            //   console.log('Inside condition');
            for (var i = this.prevselect; i > completemark; --i) {
                val[i].className = 'slds-path__item slds-is-incomplete';
            }
        }
        this.prevselect = completemark;
    }

}