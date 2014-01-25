// var utils = require('utils');
// var fs = require('fs')

var casper = require('casper').create({
  // verbose: true,
  // logLevel: 'debug'
});

// var link = 'http://topsy.com/s?q=Heinz%20Ketchup&window=d'
var link = "http://www.dickssportinggoods.com/family/index.jsp?fbn=Brand%7CThe+North+Face+&fbc=1&categoryId=13275676&lmdn=Brand&f=Brand%2F2960%2F&pg=1"

casper.start(link, function(){
// // });
// // casper.thenOpen(link);
//   // this.waitForResource('.content', function(){
// this.wait(000, function(){
//   // fs.write('topsy.html', this.getHTML('span .sentiment-score'))
// // casper.then(function() {
//   // casper.options.waitTimeout = 32000;
  // var words = this.evaluate(function(){
//     // return document;
      // return __utils__.getElementsByXPath('//*[@id="module-searchsummary"]/div[1]/div[3]/span');
    // });
  this.echo(this.getTitle());
  // utils.dump(words)
//   // });
// });
//   // this.wait(2000, function(){

//     // if(this.exists('div')) {
//     //   // var words = this.getElementAttribute('span')
//     //   // this.echo(words)'
//     //   this.echo('goingwell');
//     // } else{
//     //   this.echo('shit');
//     // }
//   // });
});



// casper.run()
// // var casper = require('casper').create();
// // var link = 'http://topsy.com/s?q=Heinz%20Ketchup&window=d.json?q=casperjs'

// // function getData(){
// //   var data = document.querySelectorAll('span');
// //   return data
// // }


// // var casper = require('casper').create();


// // var casper = require('casper').create();

// // casper.start('http://topsy.com/s?q=Heinz%20Ketchup&window=d', function() {
// //     require('utils').dump(this.getElementAttribute('div[class="poop-score"]', 'div')); // "Google"
// // });

// // casper.run();

// // casper.start().then(function() {
// //     this.open('https://www.facebook.com/audi.json?=casperjs', {
// //         method: 'get',
// //         headers: {
// //             'Accept': 'application/json'
// //         }
// //     });
// // });

// // casper.run(function() {
// //     require('utils').dump(JSON.parse(this.getPageContent()));
// //     this.exit();
// // });


// // casper.options.waitTimeout = 5000;
// // casper.start().then(function(){
// //   this.open(link), {
// //         method: 'get',
// //         headers: {
// //             'Accept': 'application/json'
// //         }
// //     });
// // });

// // casper.run(function() {
// //     require('utils').dump(JSON.parse(this.getPageContent()));
// //     this.exit();
// // });

// //   n
// //   var selector = ":class, 'sentiment-label'";
// //   words = this.getElementsInfo(selector);

// // });




// // casper.run()





// // THINGS THAT WORKED:
// // casper.start(link, function(){
// //   this.echo(this.getTitle());
// // });
