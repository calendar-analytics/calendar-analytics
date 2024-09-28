## Example API use:

<details>
<summary>Sign In</summary>

http://localhost:3000/auth/google_oauth2

User redirected to google sign in

If successful, status 204

If failed status 401

</details>

<details>
<summary>Calendars List</summary>

http://localhost:3000/api/v1/calendars

If successful receive calendar list json.
If failed status renders json error for now, will remove in prod.

</details>

<details>
<summary>Example Event Data Request with JSON</summary>

```
http://localhost:3000/api/v1/events/primary?time_min=2024-09-22&time_max=2024-09-23
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
<summary>Example Event Data Request (all day event)</summary>

```

http://localhost:3000/api/v1/events/primary?time_min=2024-09-23&time_max=2024-09-24

```

retrieves 2024-09-23 all day event, all day events are events that span 24 hours over the whole day

</details>
