
<template>
  <div class="quotes">
      <div>
        <h2>Quotes!!!</h2>
        <button v-on:click="showMovieQuotes()">Show Only Movie Quotes</button>
        <button v-on:click="showGameQuotes()">Show Only Game Quotes</button>

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
      activeQuotesData: [],
      page: 1,
      perPage: 15,
      pages: 1
    }
  },
  methods:{
      getData() {
          fetch('https://gist.githubusercontent.com/benchprep/dffc3bffa9704626aa8832a3b4de5b27/raw/quotes.json')
            .then(response => response.json())
            .then(data => this.quotesData = data);
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
          return this.quotesData = this.quotesData.filter(quote => quote.theme == "games")
      },
      showMovieQuotes(){
          return this.quotesData = this.quotesData.filter(quote => quote.theme == "movies")
      }

  },
  computed: {
	paginatedQuotes: function () {
		return this.paginate(this.quotesData);
	}
},
  watch: {
      quotesData() {
          this.getNumberOfPages()
      }
  },

  created() {
    this.getData()
  }
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
