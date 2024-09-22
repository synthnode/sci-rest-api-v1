---
to: src/<%= h.inflection.transform(name, ['pluralize', 'underscore', 'dasherize']) %>/dto/<%= h.inflection.transform(name, ['underscore', 'dasherize']) %>.dto.ts
---
import { ApiProperty } from '@nestjs/swagger';
import { IsString } from 'class-validator';

export class <%= name %>Dto {
  @ApiProperty()
  @IsString()
  id: string;
}
