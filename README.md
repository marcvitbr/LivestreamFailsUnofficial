## About this repo

This is a simple iOS client built for the Livestream Fails website. Since there is no public REST API, the responses had to be parsed from pure HTML to a simplified, specific data structure that could be used throughout the app.

I decided to support iOS 11+, since it covers the last two major releases at the time of this writing, accounting for 95% of the market share.

### Architecture

My approach was to use the Clean Architecture[[1]](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html)[[2]](https://herbertograca.com/2017/11/16/explicit-architecture-01-ddd-hexagonal-onion-clean-cqrs-how-i-put-it-all-together/) as a foundation for the solution, taking advantage of the Dependency Rule to create clear, loosely coupled relationships between objects.

### Libraries

- Alamofire: HTTP requests;
- SwiftSoup: HTML parsing;
- Kingfisher: Image downloading;

### Technical Decisions

I wanted to keep the number of external libraries to a minimum, using only the necessary to deal with complex tasks in this first few iterations.

I used a similar Android project as a reference to what CSS selectors to use to obtain the relevant information about the items ([summary](https://github.com/iffa/livestreamfails-android/blob/master/remote/src/main/java/digital/sogood/livestreamfails/remote/service/fail/FailServiceImpl.kt) and [details](https://github.com/iffa/livestreamfails-android/blob/master/remote/src/main/java/digital/sogood/livestreamfails/remote/service/details/DetailsServiceImpl.kt)).
