# ios-aws-console
This is only an idea, it might not come to much, but I thought I'd give it a go.

## The Idea
The idea behind this project to is to try and create an IOS application that can be used for managing AWS Resrouce. Yes I know that AWS already have
an application, but this is more of a challenge for myself then anything else.

## Progress
What I have so far is an iOS application that follows the Master-Detail principal. In this application the Master is a Collection view (think image thumbnails) showing the instanceas, while the detail view is a table. The idea is you click on an instance to see all the of intances detail in the table. At some point you will be able to interact with the instance such as stopping, rebooting etc.

I have the concept of a Profile. A Profile is a set of AWS IAM API Keys that are used to sign requests made to AWS. I'm using [SWASWH](https://github.com/ScottORLY/Swawsh) for this.

## This project is ongoing
While the code should compile and run, it may not work as expected 
