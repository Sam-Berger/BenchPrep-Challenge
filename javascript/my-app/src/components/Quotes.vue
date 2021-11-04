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
                <table v-for="item in paginatedQuotes" v-bind:key="item" class="table table-striped">
                    <tr>
                        <td>
                            <h2>{{item.quote}}</h2>
                            <h5>-{{item.source}} in {{item.context}}</h5>
                            <div>category: {{item.theme}}</div>
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
            fullQuotesData: [],
            paginatedQuotesArray: [],
            page: 1,
            perPage: 15,
            pages: 1,
            message: "",
            isGameQuotes: false,
            isMovieQuotes: false,
            isSearched: false
        }
    },
    methods:{
        getData() {
            fetch('https://gist.githubusercontent.com/benchprep/dffc3bffa9704626aa8832a3b4de5b27/raw/quotes.json')
            .then(response => response.json())
            .then(data => {this.quotesData = data;
            //if we just take quotesData and copy it, this new array is bound to it. 
            // We need an unbound one to manipulate, so use for loop
            let postData = [];
            for(let i=0; i<this.quotesData.length; i++) {
                postData.push(Object.assign({}, this.quotesData[i]));
            }
            this.fullQuotesData = postData 
            this.paginatedQuotesArray = postData
            })
        },
        
        getNumberOfPages(data) {
            this.pages = Math.ceil(data.length/this.perPage)
        },

        paginate(quotesData) {
            //this is not working propertly, it still thinks there are three pages after hitting games, among others
            let from = (this.page - 1) * this.perPage
            let to = this.page * this.perPage
            //remove below statment if necessary. Trial to update pages
            this.getNumberOfPages(this.paginatedQuotesArray)
            return quotesData.slice(from,to)
        },

        pageUp() {
            this.page++
        },

        pageDown(){
            this.page--
        },

        showGameQuotes(){
            return this.isGameQuotes = true, this.isMovieQuotes = false
        },

        showMovieQuotes(){
            return this.isGameQuotes = false, this.isMovieQuotes = true
        },

        search(){
            if (this.message != "") {
                return this.isSearched = true
            }
        }
    },
    computed: {
        paginatedQuotes: function () {
            let paginatedQuotesArray = this.fullQuotesData
            if (this.isGameQuotes) {
                paginatedQuotesArray = this.fullQuotesData.filter(quote => quote.theme == "games")
            }
            if (this.isMovieQuotes) {
                paginatedQuotesArray = this.fullQuotesData.filter(quote => quote.theme == "movies")
            }
            if (this.isSearched) {
                paginatedQuotesArray = paginatedQuotesArray.filter(item => ((item.quote.toLowerCase())).includes(this.message.toLowerCase()))
            }
            // this.paginatedQuotesArray = paginatedQuotesArray
            return this.paginate(paginatedQuotesArray)
        }
    },
    watch: {
        quotesData() {
            this.getNumberOfPages(this.paginatedQuotesArray)
        }
    },
    created() {
        this.getData()
    },
}
</script>