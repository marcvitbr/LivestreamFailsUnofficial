## About this repo

This is a simple iOS client built for the Livestream Fails website. Since there is no public REST API, the responses had to be parsed from pure HTML to a simplified, specific data structure that could be used throughout the app.

I decided to support iOS 11+, since it covers the last two major releases at the time of this writing, accounting for 95% of the market share.

### Architecture

My approach was to use the Clean Architecture[[1]](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html)[[2]](https://herbertograca.com/2017/11/16/explicit-architecture-01-ddd-hexagonal-onion-clean-cqrs-how-i-put-it-all-together/) as a foundation for the solution, taking advantage of the Dependency Rule to create clear, loosely coupled relationships between objects.

### Libraries

- Alamofire: HTTP requests;
- SwiftSoup: HTML parsing;

### Product Decisions

The idea was to mimic the user experience of TikTok, with the videos occupying the whole screen, but respecting the aspect ratio. Information about the video, streamer, and game appear on top of the video layer.

To move between the videos I used the same approach as TikTok, allowing the user to swipe up and down.

Another aspect borrowed from TikTok is the clean UI with the videos being loaded automatically without the need for user interaction. This helps to keep the user focused on the content.

### Technical Decisions

I wanted to keep the number of external libraries to a minimum, using only the necessary to deal with complex tasks in this first iteration.

There is only one reference to an instance of AVPlayer in memory at a time, while the app is running. Additionally, when the user swipes to the next or previous videos, the same view is reused.

I used a similar Android project as a reference to what CSS selectors to use to obtain the relevant information about the items ([summary](https://github.com/iffa/livestreamfails-android/blob/master/remote/src/main/java/digital/sogood/livestreamfails/remote/service/fail/FailServiceImpl.kt) and [details](https://github.com/iffa/livestreamfails-android/blob/master/remote/src/main/java/digital/sogood/livestreamfails/remote/service/details/DetailsServiceImpl.kt)).

### Needed improvements

- Pagination;
- Proper implementation of activity indicators and error messages;
- Fetch streamer profile picture;
- More unit tests and UI tests;
- Since the app depends on HTML controlled by 3rd parties, it would be a good idea to write tests to exercise the request and parse of the content, so that the app can respond quickly to changes.