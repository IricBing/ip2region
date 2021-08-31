import { Controller, Get, Param } from '@nestjs/common';
@Controller()
export class AppController {
  @Get(':ip')
  getHello(@Param() { ip }: { ip: string }): string {
    const searcher = require('node-ip2region').create();
    const { region } = searcher.btreeSearchSync(ip);

    return region;
  }
}
