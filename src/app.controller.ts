import { Controller, Get, Param } from '@nestjs/common';
@Controller()
export class AppController {
  private readonly searcher = require('node-ip2region').create();

  @Get(':ip')
  getHello(@Param() { ip }: { ip: string }): string {
    const { region } = this.searcher.btreeSearchSync(ip);

    return region;
  }
}
