#!/usr/bin/env python

from datetime import datetime, timedelta
import json


def main():
    with open('shell_timer.json') as data_file:
        data = json.load(data_file)
    cur_date = datetime.strptime(data["chunks"][0]["begin_date"],
                                 "%Y/%m/%d-%H:%M:%S")
    count = 1
    i = 0

    while cur_date.date() <= datetime.strptime(
            data["chunks"][-1]["begin_date"], "%Y/%m/%d-%H:%M:%S").date():

        while i < len(data["chunks"]) and cur_date.date() == \
                datetime.strptime(data["chunks"][i]["begin_date"],
                                  "%Y/%m/%d-%H:%M:%S").date():
            count += 1
            i += 1
        print(cur_date.strftime("%Y/%m/%d") + " : " + "#" * count)
        count = 0
        cur_date += timedelta(days=1)


if __name__ == '__main__':
    main()
