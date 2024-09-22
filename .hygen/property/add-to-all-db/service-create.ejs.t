---
inject: true
to: src/<%= h.inflection.transform(name, ['pluralize', 'underscore', 'dasherize']) %>/<%= h.inflection.transform(name, ['pluralize', 'underscore', 'dasherize']) %>.service.ts
after: \<creating\-property \/\>
---
<% if (isAddToDto) { -%>
  <% if (kind === 'reference') { -%>
    <% if (referenceType === 'oneToOne') { -%>
      let <%= property %>: <%= type %><% if (type === 'File') { -%>Type<% } -%> | undefined = undefined;

      if (create<%= name %>Dto.<%= property %>) {
        const <%= property %>Object = await this.<%= h.inflection.camelize(type, true) %>Service.findById(
          create<%= name %>Dto.<%= property %>.id,
        );
        if (!<%= property %>Object) {
          throw new UnprocessableEntityException({
            status: HttpStatus.UNPROCESSABLE_ENTITY,
            errors: {
              <%= property %>: 'notExists',
            },
          });
        }
        <%= property %> = <%= property %>Object;
      }
    <% } else if (referenceType === 'oneToMany' || referenceType === 'manyToMany') { -%>
      let <%= property %>: <%= type %><% if (type === 'File') { -%>Type<% } -%>[] = [];

      if (create<%= name %>Dto.<%= property %>?.length) {
        const entities = await this.<%= h.inflection.camelize(type, true) %>Service.findByIds(
          create<%= name %>Dto.<%= property %>.map((entity) => entity.id),
        );

        if (entities.length !== create<%= name %>Dto.<%= property %>.length) {
          throw new UnprocessableEntityException({
            status: HttpStatus.UNPROCESSABLE_ENTITY,
            errors: {
              <%= property %>: 'notExists',
            },
          });
        }

        <%= property %> = entities;
      }
    <% } -%>
  <% } -%>
<% } -%>