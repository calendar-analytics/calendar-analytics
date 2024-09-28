## Example API use:

<details>
<summary>Sign In</summary>

http://localhost:3000/redirect

User redirected to google sign in

If successful, user redirected to calendar list in which you get a json that lists all users calendars,
generaly 'primary' calendar should be selected unless a user opts in for other calendars to use.

If failed redirect to http://localhost:3000/

</details>

<details>
<summary>Example Calendar Data Request with JSON</summary>

```
http://localhost:3000/events/primary?time_min=2024-09-22&time_max=2024-09-23
```

retrieves 2024-09-22 day's events scheduled from 12 AM - 12 AM (next day)

```JSON
{
  "accessRole": "",
  "defaultReminders": [
    {
      "method": "",
      "minutes": null
    }
  ],
  "description": "",
  "etag": "",
  "items": [
    {
      "created": "",
      "creator": {
        "email": "",
        "self": null
      },
      "end": {
        "dateTime": "",
        "timeZone": ""
      },
      "etag": "",
      "eventType": "",
      "htmlLink": "",
      "iCalUID": "",
      "id": "",
      "kind": "",
      "organizer": {
        "email": "",
        "self": null
      },
      "reminders": {
        "useDefault": null
      },
      "sequence": null,
      "start": {
        "dateTime": "",
        "timeZone": ""
      },
      "status": "",
      "summary": "",
      "updated": ""
    }
  ],
  "kind": "",
  "nextSyncToken": "",
  "summary": "",
  "timeZone": "",
  "updated": ""
}
```

</details>

<details>
<summary>Example Calendar Data Request (all day event)</summary>

```

http://localhost:3000/events/primary?time_min=2024-09-23&time_max=2024-09-24

```

retrieves 2024-09-23 all day event, all day events are events that span 24 hours over the whole day

</details>
