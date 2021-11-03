
<template>
  <div class="quotes">
      <div>
        <h2>Quotes!!!</h2>
        <button v-on:click="showMovieQuotes()">Show Only Movie Quotes</button>
        <button v-on:click="showGameQuotes()">Show Only Game Quotes</button>
        <!-- <h1>{{activeQuotesData}}</h1>
        <h1>{{quotesData}}</h1> -->


        <!-- <h1>Page {{page}}</h1> -->
        <!-- <h1>Per Page {{perPage}}</h1> -->
        <!-- <h1>quotesLength {{quotesData.length}}</h1>
        <h1>paginatedquotesLength {{paginatedQuotes.length}}</h1> -->
        <!-- <h1>paginatedquotesLength {{paginate(quotesData)}}</h1> -->
        <!-- <h1>paginatedquotesLength {{(paginatedQuotes)}}</h1> -->
        <ul>
            <div v-for="item in paginatedQuotes" v-bind:key="item">
                <h1>{{item.quote}}</h1>
                <h2>{{item.source}}</h2>
                <h3>{{item.context}}</h3>
                <h4>{{item.theme}}</h4>
            </div>
        </ul>
      </div>
      <div class="pagination-nav">
          <button v-on:click="pageDown()" v-if="page>1">Prev</button>
          <button v-on:click="pageUp()" v-if="page <pages">Next</button>
      </div>
  </div>
</template>

<script>
export default {
  name: 'Quotes',
  props: {
    msg: String,
  },
  data: function () {
    return {
      quotesData: [],
      activeQuotesData: [123],
      activeQuotesData2: [],
      page: 1,
      perPage: 15,
      pages: 1
    }
  },
  methods:{
      getData() {
          fetch('https://gist.githubusercontent.com/benchprep/dffc3bffa9704626aa8832a3b4de5b27/raw/quotes.json')
            .then(response => response.json())
            .then(data => {
            console.log("data", data);
            this.quotesData = data;
            console.log("this", this.quotesData)

            var postData = [444];
            for(var i=0;i<(this.quotesData).length;i++) {
                postData.push(Object.assign({}, this.quotesData[i]));
            }
            console.log("postData", postData)
            this.activeQuotesData = postData 

            //the issue here is that getData is async, so the fetch takes a while, whereas the loop that was initially below i thought was happening later, it wasnt. so the for loop needs to be async too
            })
            // this.activeQuotesData=this.quotesData

        // var postData = [444];
        // console.log("start")        
        // console.log(this.quotesData)
        // console.log(this.quotesData.length)
        // for(var i=0;i<(this.quotesData).length;i++) {
        //     console.log(this.quotesData[i])
        // postData.push(Object.assign({}, this.quotesData[i]));
        // }
        // console.log(postData)
        // this.activeQuotesData = postData    
        

            // fetch('https://gist.githubusercontent.com/benchprep/dffc3bffa9704626aa8832a3b4de5b27/raw/quotes.json')
            // .then(response => response.json())
            // .then(data => this.activeQuotesData = data);

            // fetch('https://gist.githubusercontent.com/benchprep/dffc3bffa9704626aa8832a3b4de5b27/raw/quotes.json')
            // .then(response => response.json())
            // .then(data => this.activeQuotesData2 = data);
      },
      copyQuotes() {
        var postData = [444];

        for(var i=0;i<this.quotesData.length;i++) {
        postData.push(Object.assign({}, this.quotesData[i]));
        }
        this.activeQuotesData = postData    
        
      },
      getNumberOfPages() {
          this.pages = Math.ceil(this.quotesData.length/this.perPage)
      },
      paginate(quotesData) {
          let from = (this.page - 1) * this.perPage
          let to = this.page * this.perPage
          return quotesData.slice(from,to)
      },
      pageUp() {
          this.page++
      },
      pageDown(){
          this.page--
      },
      showGameQuotes(){
          return this.quotesData.filter(quote => quote.theme == "games")
      },
      showMovieQuotes(){
          return this.quotesData = this.quotesData.filter(quote => quote.theme == "movies")
      }

  },
  computed: {
      //perhaps we should change this to processedQuotes, or something like that, and do the processing for movies/games
      //but also the search functionality
	paginatedQuotes: function () {
        // console.log("paginated ", this.quotesData)
		return this.paginate(this.activeQuotesData);
	},
    copiedStuff: function() {
        return this.copyQuotes()
    }
},
  watch: {
      quotesData() {
          this.getNumberOfPages()
      }
  },
  ready: function() {
    //   this.activeQuotesData = JSON.parse(JSON.stringify(this.quotesData));
    //below does not transfer [444] without loop
        // this.copyQuotes()

  },

  created() {
    this.getData()
    //below assigns activequotesdata to [444] when not using loop
    // this.copyQuotes()
  },
}


//   created() {
//   // Simple GET request using fetch
//   fetch('https://gist.githubusercontent.com/benchprep/dffc3bffa9704626aa8832a3b4de5b27/raw/quotes.json')
//     .then(response => {
//             console.log(response);

//             // this.quotesData = response;
//     }
//   }
// }

//   created: {
//     axios.get('http://http://ideazfactory.in/library/jj.json')
//       .then(response => {
//          this.cars = response;
//       }
//   }

//   methods: {
      
//     // increment() {
//     //   // `this` will refer to the component instance
//     //   this.count++
//     // }

//     created() {
//         axios.get('https://gist.githubusercontent.com/benchprep/dffc3bffa9704626aa8832a3b4de5b27/raw/quotes.json')
//         .then(response => {
            // this.quotesData = response;
//         }
//     }
//   }

</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
