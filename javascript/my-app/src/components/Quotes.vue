
<template>
  <div class="quotes">
      <div>
        <h2>Here Are Some Quotes!</h2>
        <button v-on:click="showMovieQuotes()">Show Only Movie Quotes</button>
        <button v-on:click="showGameQuotes()">Show Only Game Quotes</button>
        <br>
        <input v-model="message" placeholder="Put Search Text Here">
        <button v-on:click="search()">Search</button>
        <ul>
            <table v-for="item in paginatedQuotes" v-bind:key="item">
                <tr>
                    <td>
                        <div>
                        {{item.quote}}
                        </div>
                        <div>
                        -{{item.source}}
                        </div>
                        <div>
                        {{item.context}}
                        </div>
                        <div>
                        {{item.theme}}
                        </div>
                    </td>
                </tr>
            </table>
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
  data: function () {
    return {
      quotesData: [],
      activeQuotesData: [],
      fullQuotesData: [],
      page: 1,
      perPage: 15,
      pages: 1,
      message: ""
    }
  },
  methods:{
      getData() {
          fetch('https://gist.githubusercontent.com/benchprep/dffc3bffa9704626aa8832a3b4de5b27/raw/quotes.json')
            .then(response => response.json())
            .then(data => {
            // console.log("data", data);
            this.quotesData = data;
            // console.log("this", this.quotesData)

            var postData = [];
            for(var i=0;i<(this.quotesData).length;i++) {
                postData.push(Object.assign({}, this.quotesData[i]));
            }
            // console.log("postData", postData)
            this.fullQuotesData = postData 
            this.activeQuotesData = this.fullQuotesData

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
    //   copyQuotes() {
    //     var postData = [444];

    //     for(var i=0;i<this.quotesData.length;i++) {
    //     postData.push(Object.assign({}, this.quotesData[i]));
    //     }
    //     this.activeQuotesData = postData    
        
    //   },
      getNumberOfPages() {
          this.pages = Math.ceil(this.activeQuotesData.length/this.perPage)
      },
      paginate(quotesData) {
          //this is not working propertly, it still thinks there are three pages after hitting games, among others
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
          return this.activeQuotesData = this.fullQuotesData.filter(quote => quote.theme == "games")
      },
      showMovieQuotes(){
          return this.activeQuotesData = this.fullQuotesData.filter(quote => quote.theme == "movies")
      },
      search(){
          console.log(this.fullQuotesData)
          console.log(this.message)
          return this.activeQuotesData = this.fullQuotesData.filter(item => ((item.quote.toLowerCase())).includes(this.message.toLowerCase()))
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
  created() {
    this.getData()
  },
}

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
