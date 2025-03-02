import { v } from 'convex/values';
import { mutation, query } from './_generated/server';

export const create = mutation({
  args: {
    title: v.string(),
    description: v.optional(v.string()),
    createdAt: v.string(),
    isCompleted: v.boolean(),
    priority: v.number(),
    category: v.number(),
  },
  handler: async (ctx, args) => {
    const newTaskId = await ctx.db.insert('tasks', { ...args });
    return newTaskId;
  },
});

export const get = query({
  args: {},
  handler: async (ctx) => {
    return await ctx.db.query('tasks').collect();
  },
});

export const toggleCompletion = mutation({
  args: {
    id: v.id('tasks'),
    isCompleted: v.optional(v.boolean()),
  },
  handler: async (ctx, args) => {
    await ctx.db.patch(args.id, { isCompleted: args.isCompleted });
    return args.id;
  },
});
