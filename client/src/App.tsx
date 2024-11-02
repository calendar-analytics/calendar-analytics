import { subDays } from "date-fns";
import Cookies from "js-cookie";
import React from "react";
import type { DateRange } from "react-day-picker";

import { Button } from "@/components/ui/button";
import { DatePickerWithRange } from "@/components/ui/date-picker-with-range";

function App() {
  const [date, setDate] = React.useState<DateRange | undefined>({
    from: new Date(),
    to: subDays(new Date(), 7),
  });

  const csrfToken = Cookies.get("CSRF-TOKEN");
  // NOTE: temporary solution to check if user is authenticated
  const hasAuth = !!csrfToken;

  const getCalendarData = async () => {
    const fromDate = date?.from?.toISOString().split("T")[0];
    const toDate = date?.to?.toISOString().split("T")[0];
    try {
      const response = await fetch(
        `${
          import.meta.env.VITE_API_URL
        }/api/v1/events/primary?time_min=${toDate}&time_max=${fromDate}`,
        {
          mode: "cors",
          credentials: "include",
        }
      );
      const data = await response.json();

      console.log(data);

      // eslint-disable-next-line @typescript-eslint/no-explicit-any
    } catch (error: any) {
      console.error("Error:", error.message);
    }
  };

  return (
    <>
      {hasAuth ? (
        <>
          <DatePickerWithRange date={date} setDate={setDate} />
          <Button onClick={getCalendarData}>Show Analytics</Button>
        </>
      ) : (
        <Button>
          <a href={`${import.meta.env.VITE_API_URL}/auth/google_oauth2`}>
            Connect your Google Calendar
          </a>
        </Button>
      )}
    </>
  );
}

export default App;
