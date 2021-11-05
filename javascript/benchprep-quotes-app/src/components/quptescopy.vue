<template>
    <div class="quotes">
        <div>
            <h2>Here Are Some Quotes!</h2>
            <h1>pageniatedquotesarray length {{paginatedQuotesArray.length}}</h1>
            <!-- <h1>{{paginatedQuotesArray}}</h1> -->
            <h1>pages {{pages}}</h1>
            <h1>current page {{page}}</h1>


            <button v-on:click="showAllQuotes()">Show All Quotes</button>
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
            perPage: 2,
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
            // this.getNumberOfPages(this.paginatedQuotesArray)
            console.log("paginated stuff", quotesData.slice(from,to))
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

        showAllQuotes(){
            return this.isGameQuotes = false, this.isMovieQuotes = false
        },

        search(){
            if (this.message != "") {
                return this.isSearched = true
            }
        }
    },
    computed: {
        //perhaps this should be filtered quotes and have another function called paginatedQuotes
        paginatedQuotes: function () {
            let paginatedQuotesArray = this.fullQuotesData
            // console.log(paginatedQuotesArray)
            if (this.isGameQuotes) {
                paginatedQuotesArray = this.fullQuotesData.filter(quote => quote.theme == "games")
            }
            if (this.isMovieQuotes) {
                paginatedQuotesArray = this.fullQuotesData.filter(quote => quote.theme == "movies")
            }
            if (this.isSearched) {
                paginatedQuotesArray = paginatedQuotesArray.filter(item => ((item.quote.toLowerCase())).includes(this.message.toLowerCase()))
            }
            //this is actually unncessary and  causes an infinite loop
            //this may be unncessary
            // this.getNumberOfPages(this.paginatedQuotesArray)
            
            console.log("paginated after", paginatedQuotesArray)
            return paginatedQuotesArray// this.paginatedQuotesArray = paginatedQuotesArray
            // return this.paginate(paginatedQuotesArray)
        }
    },
    watch: {
        paginatedQuotes: {
            deep: true,
            handler: function (newVal) {
                this.paginatedQuotesArray = newVal
                // this.getNumberOfPages(this.paginatedQuotesArray)
            }
        },
        quotesData() {
            this.getNumberOfPages(this.paginatedQuotesArray)
        }
    },
    created() {
        this.getData()
    },
}
</script>