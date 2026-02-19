//--------------------------------------------------------------
//
// ArrayList
//
//--------------------------------------------------------------
ArrayList = function arrayList() {

    this.list = [];

    this.add = function (item) {
        this.list.push(item);
    };

    this.get = function (index) {
        return this.list[index];
    };
    
    this.removeAll = function () {
        this.list = [];
    };

    this.clear = function () {
        this.list = [];
    }

    this.size = function () {
        return this.list.length;
    };

    this.remove = function (index) {
        var newList = [];
        for (var i = 0; i < this.list.length; i++) {
            if (i != index) {
                newList.push(this.list[i]);
            };
        };
        this.list = newList;
    };

    this.remove_item = function (item) {
        var newList = [];
        for (var i = 0; i < this.list.length; i++) {
            if (item != this.list[i]) {
                newList.push(this.list[i]);
            };
        };
        this.list = newList;
    };
};