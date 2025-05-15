# LIWI AI

# Flow
```
OnboardingFlow 
    -> GetStartedPage
        -> SignUpPage
        |   -> LanguageSelectionScreen
        |       -> IntroNamePage
        |           -> AiTutorIntroPage
        |               -> AiTutorPage (6) [ReviewPage (1)]
        |                   -> AllSetPage
        -> LoginPage
            -> HomePage
                -> ChattingPage
                -> Profile
```