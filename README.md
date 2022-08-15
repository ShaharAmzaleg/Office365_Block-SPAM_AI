# Office365_Block-SPAM_AI


Designed for organizations with 0ffice365 services.

This process enables automatic learning and blocking of what your organization's users have identified as spam.

## How its works?

Outlook have ability to deploy integrated app and we will use "Report Message" button.
This button gives to our users ability to report about spam, We will use these reports to block these addresses in the organization's exchange online.


**The steps is:**
- Deploy "Report Message" button
- Create a shared folder to store the suspected spam
- Config "Report Message" button
- Run scheduled script to learn and enforce the messages


**lets start :)**

## Deploy "Report Message" button


**Get the Report Message add-in for your organization**

- Note - It could take up to 12 hours for the add-in to appear in your organization.

**1)** In the [Microsoft 365 admin center](https://admin.microsoft.com/AdminPortal/Home?#/homepage), go to Settings > Integrated apps. Click Get apps.

The Microsoft 365 admin center Integrated apps.
![image](https://user-images.githubusercontent.com/11631443/184556550-52a62fbb-2cf0-4b3a-9462-bb94c1fb1ee4.png)

**2)** In the Microsoft 365 Apps page that appears, click in the Search box, enter Report Message, and then click Search Search icon.. In the list of results, find and select Report Message.

**3)** The app details page opens. Select Get It Now.

![image](https://user-images.githubusercontent.com/11631443/184556672-483bd5c5-d94f-40d2-8756-f152a169f1c6.png)

**4)** Complete the basic profile information, and then click Continue.

![image](https://user-images.githubusercontent.com/11631443/184556682-47e474bb-18a1-439d-8ce4-b60496f8b5fa.png)

**5)** The Deploy New App flyout opens. Configure the following settings. Click Next to go to the next page to complete setup.

**Add users:** Select one of the following values:

- Just me
- Entire organization
- Specific users / groups
  
**Deployment:**

- Accept Permissions requests: Read the app permissions and capabilities carefully before going to the next page.
  ![image](https://user-images.githubusercontent.com/11631443/184556717-a9f72e91-2d58-4719-8538-fdf1a1308f08.png)

- Finish deployment: Review and finish deploying the add-in.
- Deployment completed: Select Done to complete the setup.
  
  ![image](https://user-images.githubusercontent.com/11631443/184556734-e8933dc5-5403-43ec-b9b0-89d6ae48b5fd.png)



## Create a shared folder to store the suspected spam


 **Create a shared mailbox**

**1)**  Sign in with a global admin account or Exchange admin account. If you get the message "**You don't have permission to access this page or perform this action**," then you aren't an admin.

**2)**  In the admin center, go to the  **Teams & Groups**  >  [Shared mailboxes](https://go.microsoft.com/fwlink/p/?linkid=2066847)  page.

**3)**  On the  **Shared mailboxes**  page, select  **+ Add a shared mailbox**. Enter a name for the shared mailbox. This chooses the email address, but you can edit it if needed.
![image](https://user-images.githubusercontent.com/11631443/184557830-9a3eca27-fc76-470b-bc39-ffcd9f6e41b6.png)




## Config "Report Message" button

**1)** Open [User reported message settings](https://security.microsoft.com/userSubmissionsReportMessage)

**2)** Set up a Reporting Mailbox – Here you can configure to send a copy of reported messages to a centralized mailbox.

![](https://i.imgur.com/8SO2dzA.png)

**3)** Config User reporting experience - allows you to configure custom messages shown before and after the user reports messages.


## Run scheduled script to learn and enforce the messages

**Run the ps1 script (Block_spam_Address_AI.ps1) every night 1AM.**
* Dont forget to change the variables before first running







**Contribution**
Whether you have ideas, translations, design changes, code cleaning, or even major code changes, help is always welcome.
