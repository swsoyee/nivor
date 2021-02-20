import { reactWidget } from 'reactR';
import { ResponsiveCalendar, ResponsiveCalendarCanvas } from '@nivo/calendar';
import { ResponsiveAreaBump } from '@nivo/bump';

reactWidget(
  'calendar',
  'output',
  { ResponsiveCalendar, ResponsiveCalendarCanvas, ResponsiveAreaBump },
  {},
);
