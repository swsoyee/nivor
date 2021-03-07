import { reactWidget } from 'reactR';
import { ResponsiveCalendar, ResponsiveCalendarCanvas } from '@nivo/calendar';
import { ResponsiveAreaBump, ResponsiveBump } from '@nivo/bump';
import { ResponsiveLine, ResponsiveLineCanvas } from '@nivo/line';
import { ResponsiveScatterPlot, ResponsiveScatterPlotCanvas } from "@nivo/scatterplot";
import { ResponsiveChord, ResponsiveChordCanvas } from "@nivo/chord";
import { ResponsiveWaffle, ResponsiveWaffleHtml, ResponsiveWaffleCanvas } from "@nivo/waffle";
import { ResponsiveVoronoi } from "@nivo/voronoi";
import { ResponsivePie, ResponsivePieCanvas } from "@nivo/pie";
import { ResponsiveParallelCoordinates, ResponsiveParallelCoordinatesCanvas } from "@nivo/parallel-coordinates";

reactWidget(
  'calendar',
  'output',
  { 
    ResponsiveCalendar, 
    ResponsiveCalendarCanvas, 
    ResponsiveAreaBump, 
    ResponsiveBump,
    ResponsiveLine, 
    ResponsiveLineCanvas,
    ResponsiveScatterPlot,
    ResponsiveScatterPlotCanvas,
    ResponsiveChord,
    ResponsiveChordCanvas,
    ResponsiveWaffle, 
    ResponsiveWaffleHtml,
    ResponsiveWaffleCanvas,
    ResponsiveVoronoi,
    ResponsivePie, 
    ResponsivePieCanvas,
    ResponsiveParallelCoordinates,
    ResponsiveParallelCoordinatesCanvas,
  },
  {},
);
